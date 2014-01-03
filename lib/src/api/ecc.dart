// Copyright (c) 2013, Iván Zaera Avellón - izaera@gmail.com
// Use of this source code is governed by a LGPL v3 license.
// See the LICENSE file for more information.

part of cipher.api;

/// Standard ECC curve description
abstract class ECDomainParameters {

	/// The [Registry] for [ECDomainParameters] objects
	static final registry = new Registry<ECDomainParameters>();

  /// Get this domain's standard name.
  String get domainName;

	ECCurve get curve;
  List<int> get seed;
  ECPoint get G;
  BigInteger get n;

  factory ECDomainParameters( String domainName ) => registry.create(domainName);

}

/// Type for coordinates of an [ECPoint]
abstract class ECFieldElement {

  BigInteger toBigInteger();
  String get fieldName;
  int get fieldSize;

	int get byteLength;

  ECFieldElement operator +( ECFieldElement b );
  ECFieldElement operator -( ECFieldElement b );
  ECFieldElement operator *( ECFieldElement b );
  ECFieldElement operator /( ECFieldElement b );

  ECFieldElement operator -();

  ECFieldElement invert();
  ECFieldElement square();
  ECFieldElement sqrt();

}

/// An elliptic curve point
abstract class ECPoint {

  ECCurve get curve;
  ECFieldElement get x;
  ECFieldElement get y;

	bool get isCompressed;
  bool get isInfinity;

  bool operator ==(other);

  Uint8List getEncoded([bool compressed = true]);

  ECPoint operator +(ECPoint b);
  ECPoint operator -(ECPoint b);
  ECPoint operator -();

  ECPoint twice();

  /**
   * Multiplies this <code>ECPoint</code> by the given number.
   * @param k The multiplicator.
   * @return <code>k * this</code>.
   */
  ECPoint operator *(BigInteger k);

}

/// An elliptic curve
abstract class ECCurve {

	ECFieldElement get a;
	ECFieldElement get b;

	int get fieldSize;
	ECPoint get infinity;

	ECFieldElement fromBigInteger( BigInteger x );
	ECPoint createPoint( BigInteger x, BigInteger y, [bool withCompression=false] );
	ECPoint decompressPoint( int yTilde, BigInteger X1 );

	/**
	 * Decode a point on this curve from its ASN.1 encoding. The different
	 * encodings are taken account of, including point compression for
	 * <code>F<sub>p</sub></code> (X9.62 s 4.2.1 pg 17).
	 * @return The decoded point.
	 */
	ECPoint decodePoint( List<int> encoded );

}

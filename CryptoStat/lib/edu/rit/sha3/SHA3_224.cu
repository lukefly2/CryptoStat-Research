//******************************************************************************
//
// File:    SHA3_224.cu
// Unit:    SHA3-224 CUDA functions
// Author:  Aziel Shaw
//
// This CUDA source file is copyright (C) 2019 by Alan Kaminsky. All rights
// reserved. For further information, contact Alan Kaminsky at ark@cs.rit.edu.
//
// This CUDA source file is part of the CryptoStat Library ("CryptoStat").
// CryptoStat is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// CryptoStat is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// A copy of the GNU General Public License is provided in the file gpl.txt. You
// may also obtain a copy of the GNU General Public License on the World Wide
// Web at http://www.gnu.org/licenses/gpl.html.
//
//******************************************************************************

#ifndef __SHA3224_CU__
#define __SHA3224_CU__

#include <stdint.h>
#include "../util/BigInt.cu"

// The number of Padding bytes
#define numPaddingBytes 10

// Define the ReverseBytes Method
__device__ uint64_t reverseBytes(uint64_t x);

/**
 * Record digest for the current round. Working variables a through hh are
 * stored in the proper words of the digest (dig).
 */
__device__ void recordDigest
	(uint32_t* dig,
	 uint64_t a,
	 uint64_t b,
	 uint64_t c,
	 uint64_t d,
	 uint64_t e,
	 uint64_t f,
	 uint64_t g,
	 uint64_t h) {
	uint64_t tmp;
	tmp = reverseBytes(a);
	dig[6] = (uint32_t)(tmp >> 32);
	dig[5] = (uint32_t)(tmp);
	tmp = reverseBytes(b);
	dig[4] = (uint32_t)(tmp >> 32);
	dig[3] = (uint32_t)(tmp);
	tmp = reverseBytes(c);
	dig[2] = (uint32_t)(tmp >> 32);
	dig[1] = (uint32_t)(tmp);
	tmp = reverseBytes(d);
	dig[0] = (uint32_t)(tmp >> 32);
}

#include "SHA3Base.cu"

#endif
#!/bin/bash

function ldifparse ()
{
	awk 'length > 79 {
	n=1
	while ( length($0) > 78 + n ) {
		printf "%s\n ", substr($0,1,78 + n)
		$0 = substr($0,79 + n)
		n=0
	}
	if (length) print
		next
	}
	{print}' "$FILE"
}

From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Oct 2018 15:20:30 +0200
Subject: [LTP] LTP: keyctl05: unexpected error adding 'dns_resolver'
	key: EINVAL
In-Reply-To: <CA+G9fYvWRJ-+B_vXzFdnT2c9f0+o8p=RP23ZNAxMMzMd3TMbYQ@mail.gmail.com>
References: <CA+G9fYvWRJ-+B_vXzFdnT2c9f0+o8p=RP23ZNAxMMzMd3TMbYQ@mail.gmail.com>
Message-ID: <20181008132029.GA30978@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> keyctl05.c:135: INFO: Try to update the 'asymmetric' key...
> keyctl05.c:148: PASS: updating 'asymmetric' key expectedly failed with
> EOPNOTSUPP
> keyctl05.c:119: BROK: unexpected error adding 'dns_resolver' key: EINVAL
> tst_test.c:884: BROK: Test 1 haven't reported results!

Looks like kernel does not know 'dns_resolver' key type and as this type
is registered by the dns_resolver code I suppose that you are missing
some CONFIG_DNS_RESOLVER, if that is the case the test should handle
EINVAL and return with TCONF.

-- 
Cyril Hrubis
chrubis@suse.cz

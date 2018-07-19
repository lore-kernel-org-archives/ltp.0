From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jul 2018 17:11:55 +0200
Subject: [LTP] [PATCH v3 1/3] lib: Add tst_crypto and tst_netlink libs
In-Reply-To: <20180705145635.27244-1-rpalethorpe@suse.com>
References: <20180705145635.27244-1-rpalethorpe@suse.com>
Message-ID: <20180719151155.GB24467@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void tst_crypto_open(struct tst_crypto_session *ses)
> +{
> +	TEST(socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO));
> +	if (TEST_RETURN < 0 && TEST_ERRNO == EPROTONOSUPPORT) {
> +		tst_brk(TCONF | TTERRNO, "NETLINK_CRYPTO is probably disabled");
> +	} else if (TEST_RETURN < 0) {
> +		tst_brk(TBROK | TTERRNO,
> +			"socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO)");
> +	}

I got rid of this else branch, since we call tst_brk() in the first if
it's not needed at all, and pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

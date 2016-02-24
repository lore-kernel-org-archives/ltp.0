From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2016 15:28:44 +0100
Subject: [LTP] [PATCH v2 3/3] llistxattr/llistxattr03.c: add new testcase
In-Reply-To: <1455857746-25721-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160218120305.GE19157@rei.lan>
 <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1455857746-25721-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160224142844.GE8292@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_llistxattr(void)
> +{
> +	TEST(llistxattr("testfile", NULL, 0));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TERRNO, "llistxattr() failed");
> +		return;
> +	}

For me the call returns 0 here.

Can we create another file with some attribute in the setup as well so
that we can test both with no attributes (zero sized buffer) and with
non-zero one?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

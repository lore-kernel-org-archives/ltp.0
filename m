From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2016 14:38:14 +0100
Subject: [LTP] [PATCH v2 1/3] llistxattr/llistxattr01.c: add new testcase
In-Reply-To: <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160218120305.GE19157@rei.lan>
 <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160224133814.GC8292@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The testcase checks the basic functionality of the llistxattr(2).
> llistxattr(2) retrieves the list of extended attribute names
> associated with the link itself in the filesystem.

I've added tst_require_root() into the test setup, since modifying
attrinbutes in security namespace requires it.

> +static void set_xattr(const char *path, const char *key)
> +{
> +	int n;
> +
> +	n = lsetxattr(path, key, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup,
> +				 "no xattr support in fs or mounted "
> +				 "without user_xattr option");
> +		}
> +
> +		if (errno == EEXIST) {
> +			tst_brkm(TFAIL, cleanup, "exist attribute %s", key);
> +		} else {
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				 "lsetxattr() failed");

And changed these two to TBROK since it's more "test broken in setup"
rather than "test assertion failed".

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

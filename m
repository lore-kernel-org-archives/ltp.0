From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jun 2017 13:43:39 +0200
Subject: [LTP] [PATCH 1/2] syscalls/open01: Cleanup && convert to new
 library
In-Reply-To: <1497005761-1215-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1497005761-1215-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170613114339.GD29757@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct tcase {
> +	char *filename;
> +	int flag;
> +	mode_t mode;
> +	unsigned short tst_bit;
> +	char *desc;
> +} tcases[] = {
> +	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "Sticky bit"},
> +	{TEST_DIR, O_DIRECTORY, NULL, S_IFDIR, "Directory bit"}
                                  ^
				  This should be just 0 or 00 but not
				  NULL.

Also it would be a bit safer if we opened a directory created in a the
test temporary directory instead of "/tmp". We just have to do
SAFE_MKDIR() in setup() and use it's name as a relative path.

-- 
Cyril Hrubis
chrubis@suse.cz

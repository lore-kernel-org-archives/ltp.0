From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Mar 2018 15:07:23 +0100
Subject: [LTP] [PATCH] mtest06: Use temp dir from $TMPDIR if present
In-Reply-To: <20180308005250.210404-1-hridya@google.com>
References: <20180308005250.210404-1-hridya@google.com>
Message-ID: <20180308140722.GA26706@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good catch, but given that the temporary directory created by
tst_tmpdir() is unique we can as well drop the whole mkstemp()
and replace it with just open().

#define FNAME "ashfile"

int mkfile(int size)
{
	int fd;

	fd = open(FNAME,  O_RDWR | O_CREAT, 0600);
	if (fd < 0)
		tst_brk(...);

	unlink(FNAME);

	...

	return fd;
}


-- 
Cyril Hrubis
chrubis@suse.cz

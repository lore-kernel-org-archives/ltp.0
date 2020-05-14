From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 09:11:21 +0200
Subject: [LTP] [PATCH] Add missing mode argument to open(..., O_CREAT)
In-Reply-To: <20200513152914.2703-1-mdoucha@suse.cz>
References: <20200513152914.2703-1-mdoucha@suse.cz>
Message-ID: <20200514071121.GA7101@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Marting,

thank you, good catch.

According to man open(2), mode must be specified when O_CREAT or O_TMPFILE is
specified in flags. Thus it looks to me that also these files are missing mode:

testcases/kernel/syscalls/fallocate/fallocate05.c
fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT | O_TRUNC);

testcases/kernel/syscalls/fallocate/fallocate06.c
fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC);

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

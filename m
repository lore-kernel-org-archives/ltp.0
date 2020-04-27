From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 19:36:02 +0200
Subject: [LTP] [PATCH v2 2/3] testcases/kernel/syscalls/ioctl: Add test
 for RTC ioctls used to read and set RTC alarm time
In-Reply-To: <20200423150626.12672-3-fbozuta1@gmail.com>
References: <20200423150626.12672-1-fbozuta1@gmail.com>
 <20200423150626.12672-3-fbozuta1@gmail.com>
Message-ID: <20200427173602.GA14375@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Filip,

> +		for (int i = 0; i < 3; i++)
Minor nit: we still support old gcc 4 in centOS 6 build, which doesn't use C99
by default, thus it fails when int is defined inside loop. Trivial fix (in case
there is no v2 needed it could be changed by person who merges):
int i;
for (i = 0; i < 3; i++)
...

https://api.travis-ci.org/v3/job/680146814/log.txt
/usr/src/ltp/testcases/kernel/syscalls/ioctl/ioctl_rtc02.c: In function 'setup':
/usr/src/ltp/testcases/kernel/syscalls/ioctl/ioctl_rtc02.c:32: warning: left-hand operand of comma expression has no effect
/usr/src/ltp/testcases/kernel/syscalls/ioctl/ioctl_rtc02.c: In function 'run':
/usr/src/ltp/testcases/kernel/syscalls/ioctl/ioctl_rtc02.c:95: error: 'for' loop initial declarations are only allowed in C99 mode
/usr/src/ltp/testcases/kernel/syscalls/ioctl/ioctl_rtc02.c:95: note: use option -std=c99 or -std=gnu99 to compile your code

https://travis-ci.org/github/pevik/ltp/builds/680146805

Kind regards,
Petr

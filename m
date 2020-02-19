From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Feb 2020 09:23:59 +0100
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
 <20200217133638.GB14410@rei>
 <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
Message-ID: <20200219082359.GA21099@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

as somebody (probably Li) pointed out fsopen/fsopen01.c is similar to fsmount/fsmount01.c,
so please during rebase drop it. BTW for this dropped test I'd use different
approach (close fd in cleanup function and use tst_brk(TFAIL instead of
tst_res(TBROK and goto):

static void cleanup(void)
{
	if (fd > 0)
		SAFE_CLOSE(fd);
}

...
	if (fd == -1)
		tst_brk(TFAIL | TERRNO, "fsopen() failed");

Also you added autotools check for functions (e.g. fsopen) during commits, but I
move them to the first (together with lapi header).

Kind regards,
Petr

From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jan 2020 10:49:16 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <CAEemH2dUhpixZoorh_-H1CHenk9-XG9ZocjHB30RqzW_Kb0dCw@mail.gmail.com>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
 <20200108114141.GB17272@rei.lan> <20200108114545.GA28867@dell5510>
 <CAEemH2dUhpixZoorh_-H1CHenk9-XG9ZocjHB30RqzW_Kb0dCw@mail.gmail.com>
Message-ID: <20200109094916.GA31981@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The reason why not use tst_syscall() is that involves a new compile error
> of tst_brk, and it can not get rid of errors only via include tst_test.h
> file.

The problem is that the header is used both for old and new test API, so
until we convert the rest of the oldlib testcases we can't use anything
from the new library there.

We solve that in other places by ifdefs, such as:

#ifdef TST_TEST_H__
	tst_syscall(...);
#else
	ltp_syscall(...);
#endif


-- 
Cyril Hrubis
chrubis@suse.cz

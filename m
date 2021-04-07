From: zhaogongyi <zhaogongyi@huawei.com>
Date: Wed, 7 Apr 2021 08:21:43 +0000
Subject: [LTP] [PATCH] syscalls/getdtablesize01: Add abnormal handling
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038A8DA8@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your review!

I have resubmit the patch and rewrite the getdtablesize01.c with new api.

See https://patchwork.ozlabs.org/project/ltp/patch/20210407081415.8353-1-zhaogongyi@huawei.com/

Thanks!

Best Regards,
Gongyi

> 
> Hi,
> 
> > When /etc/hosts is not exist, test would fail, actually, we chould
> > skip the the problem to improve maintainability.
> 
> ...
> > +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> > @@ -100,6 +100,8 @@ int main(void)
> >  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
> >  	else if (fd < 0 && errno == ENFILE)
> >  		tst_brkm(TCONF, cleanup, "Reached maximum number of open
> files for
> > the system");
> > +	else if (fd == 0)
> > +		tst_brkm(TCONF, cleanup, "Maybe /etc/hosts is not exist");
> >  	else
> >  		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
> 
> Why not to test for existence of the file in main(), where is file being
> opened?
> 
> 	fd = open("/etc/hosts", O_RDONLY);
> 
> Also current patch does not work when I test on system without
> /etc/hosts:
> 
> ./getdtablesize01
> getdtablesize01    0  TINFO  :  Maximum number of files a process can
> have opened is 1024
> getdtablesize01    0  TINFO  :  Checking with the value returned by
> getrlimit...RLIMIT_NOFILE
> getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
> getdtablesize01    0  TINFO  :  Checking Max num of files that can be
> opened by a process.Should be: RLIMIT_NOFILE - 1
> getdtablesize01    2  TFAIL  :  getdtablesize01.c:106: 0 != 1023
> 
> Besides, it'd help to also rewrite the test to the new API.
> 
> Kind regards,
> Petr

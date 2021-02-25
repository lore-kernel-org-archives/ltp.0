From: ruansy.fnst@fujitsu.com <ruansy.fnst@fujitsu.com>
Date: Thu, 25 Feb 2021 02:11:12 +0000
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCAxLzJdIHN5c2NhbGxzL2dldHBp?=
 =?gb2312?b?ZDAxOiBDb252ZXJ0IHRvIG5ldyBBUEk=?=
In-Reply-To: <YDYqZMYBVfh8oiYH@yuki.lan>
References: <20210224031227.151844-1-ruansy.fnst@cn.fujitsu.com>,
 <YDYqZMYBVfh8oiYH@yuki.lan>
Message-ID: <OSBPR01MB2920DF74B48CA7A680A03257F49E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > +static void verify_getpid(void)
> >  {
> > +     TEST(getpid());
> > 
> > -     tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > -
> > -     TEST_PAUSE;
> > +     if (TST_RET == -1)
> > +             tst_res(TFAIL | TTERRNO, "getpid()");
> > +     else
> > +             tst_res(TPASS, "getpid() returns %ld", TST_RET);
>
> The POSIX actually mandates that getpid() cannot fail and is always
> successful. Given that this test seems to be useless and could be
> removed or replaced with something more sane.
>
> I guess that what we can do is to check if the return value from
> getpid() is greater than 1, since pid 1 is special no other process than
> init can have pid == 1. And the value has to be smaller or equal to
> /proc/sys/kernel/pid_max as well.
>
> So what would I do here would be:
>
> * read /proc/sys/kernel/pid_max value
> * loop 100 times or so
>   - fork a child
>   - check that the pid in child is > 1 and <= pid_max

Do you mean loop 100 times to fork 100 children processes?  I tried in this
way and found that the pid number just increased sequentially from +0 to +100
(Because no other processes were created during the test).  So, I am not sure
if 100 times is enough to test the range?


--
Thanks,
Ruan Shiyang.

>
> --
> Cyril Hrubis
> chrubis@suse.cz

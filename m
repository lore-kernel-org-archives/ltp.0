From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Apr 2020 10:55:44 +0200
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <d3063175-5014-51ea-9d1c-4a9f3e2243b1@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
 <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
 <48142e6b-8169-2934-e8b2-f71927cd62b0@cn.fujitsu.com>
 <20200420130140.GB11604@yuki.lan>
 <d3063175-5014-51ea-9d1c-4a9f3e2243b1@cn.fujitsu.com>
Message-ID: <20200421085544.GB6577@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +void tst_assert_file_str(const char *file, const int lineno, const char
> >> *path, const char *buf, const char *val)
> >> +{
> >> +       char sys_val[1024];
> >> +
> >> +       SAFE_FILE_LINES_SCANF(path, buf, sys_val);
> > 
> > We should call the file_lines_scanf() here and pass the filename and
> > lineno that this functions takes as parameter instead.
> I don't understand the meaning of adding filename and line parameter(If 
> fail, it will report tst_assert.c: 29). Do you want to report the 
> correct parsed filename when failed?
> 
> If so, I think lineno is meaningless and it also overides the place of 
> the code meet problem . I prefer to add some path info in safe_file_ops.c.

What I want is to show the test source filename and line on failure, for
that we have to pass the lineno and file to the file_lines_scanf()
function. I think that it makes much more sense to print the line in a
test where the problem has happened rather than some location in the
library code.

-- 
Cyril Hrubis
chrubis@suse.cz

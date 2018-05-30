From: Li Wang <liwang@redhat.com>
Date: Wed, 30 May 2018 17:52:25 +0800
Subject: [LTP] [PATCH] pty: using tcgetattr() to get attributes before
 re-setting it
In-Reply-To: <5B0CFB5C.5040702@cn.fujitsu.com>
References: <20180528103936.22538-1-liwang@redhat.com>
 <5B0CFB5C.5040702@cn.fujitsu.com>
Message-ID: <CAEemH2fr-5HAJdFL_Br7u2bsry5E3j_dwaVnnJFdm4wFTWsA0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Xiao,

On Tue, May 29, 2018 at 3:03 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Hi Li,
>
> We found other issues by running pty02:
> 1) The undefined EXTPROC flag led to complier error on RHEL5/6.
> 2) Based on the fix, reading pts blocked on RHEL6 because we didn't write
> newline('\n') to ptmx,
>    but it worked well on RHEL7.  I am not sure which kernel patch changed
> this behavior.
>    According canonical mode description:
>        In canonical mode:
>        * Input is made available line by line.  An input line is available
> when one of the line
>          delimiters is typed (NL, EOL, EOL2; or EOF at the start of
> line).  Except in the case of EOF,
>          the line delimiter is included in the buffer returned by read(2).
> 3) Based on the fix,
> ​​
> tcsetattr(3) cannot detect invalid EXTPROC flag on RHEL5/6.
>

AFAIK, values of the c_lflag field describe the control of various
functions in struct termios,
but it not defined in POSIX and not supported under all Linux. So
​
tcsetattr() cannot detect valid EXTPROC on RHEL5/6 is acceptable I think.
Also, the ICANON has different behavior on some kind of UNIX OS too.

To solve these problem, maybe we have to define the EXTPROC in lapi, and
skip this test on kernel without that support.

That's what I can think of, if anything wrong, plz correct me.

Thanks,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180530/dd3bf31c/attachment.html>

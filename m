From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jan 2020 13:48:47 +0100
Subject: [LTP] [PATCH v2] Fix prctl02
In-Reply-To: <b2a63820-656c-de66-cde2-ce91c62e52b6@163.com>
References: <239304412.3515101.1579791334045.JavaMail.zimbra@redhat.com>
 <20200123151836.29484-1-mdoucha@suse.cz>
 <b2a63820-656c-de66-cde2-ce91c62e52b6@163.com>
Message-ID: <20200124124847.GB31214@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The prctl() system call takes 5 integer arguments but only 3 of them were
> > passed in the test. This means that the system call read random garbage
> > from stack in place of the two missing arguments and failed even on some
> > perfectly valid combinations of arguments on some platforms.
> > 
> > - Change num_invalid to ULONG_MAX
> > - Fix arguments in test case 9, 13 and 14
> > - Fix test call of prctl() to have all 5 arguments
> looks prctl manpages and kernel code, you are right, Thanks for the fix!
> Feel free to add??
> Reviewed-by: xuyang_jy_0410@163.com
> Tested-by: xuyang_jy_0410@163.com
> 
> Also, do we should use 5 arguments for other prctl test cases?

It depends on the option argument, the PR_CAP_AMBIENT explicitely states
that arg4 and arg5 must be set to 0 as well as the
PR_GET_SPECULATION_CTRL.

Some of the options explicitely say that some arguments are ignored.

And some, including PR_SET_NO_NEW_PRIVS does not say anyting.

-- 
Cyril Hrubis
chrubis@suse.cz

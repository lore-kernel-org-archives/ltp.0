From: nousi <bnousilal@gmail.com>
Date: Mon, 25 Jul 2016 17:55:45 +0530
Subject: [LTP] execute group of test cases.
In-Reply-To: <20160725121851.GA12533@rei>
References: <CAJ5vXcRN8wb4=XwvTU38cfUy0f22nmwDWW8Q7OvUbkLpGO4wbg@mail.gmail.com>
 <20160725121851.GA12533@rei>
Message-ID: <CAJ5vXcQpnQ-8MkDBTcbaxktSWBSMpOfvZJi2HaRLy-APjcio5w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you, Cyril Hrubis!.

On Mon, Jul 25, 2016 at 5:48 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > How can I run only below test cases using "runltp" command. I now below
> > command but do not know the argument to pass.
> > ./runltp -p -l <log file name> -f <testcase name>
> >
> > Is there any way to run ?
> >
> >
> > netns_breakns_ns_exec_ipv4_
> > netns_breakns_ns_exec_ipv6_
> > netns_breakns_ns_exec_ipv4_
> > netns_breakns_ns_exec_ipv6_
> > netns_breakns_ip_ipv4_netli
> > netns_breakns_ip_ipv6_netli
> > netns_breakns_ip_ipv4_ioctl
> > netns_breakns_ip_ipv6_ioctl
> > netns_comm_ns_exec_ipv4_net
> > netns_comm_ns_exec_ipv6_net
> > netns_comm_ns_exec_ipv4_ioc
> > netns_comm_ns_exec_ipv6_ioc
> > netns_comm_ip_ipv4_netlink
> > netns_comm_ip_ipv6_netlink
> > netns_comm_ip_ipv4_ioctl
> > netns_comm_ip_ipv6_ioctl
>
> The easiest way is to create custom runtest file, i.e. copy
> runtest/containers to new file and delete what you do not want to run.
> Then you can pass the newly created file name via the -f argument.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 


*Thanks & Regards,B.Nousilal,*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160725/0e3e8667/attachment.html>

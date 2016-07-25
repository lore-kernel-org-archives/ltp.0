From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jul 2016 14:18:51 +0200
Subject: [LTP] execute group of test cases.
In-Reply-To: <CAJ5vXcRN8wb4=XwvTU38cfUy0f22nmwDWW8Q7OvUbkLpGO4wbg@mail.gmail.com>
References: <CAJ5vXcRN8wb4=XwvTU38cfUy0f22nmwDWW8Q7OvUbkLpGO4wbg@mail.gmail.com>
Message-ID: <20160725121851.GA12533@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> How can I run only below test cases using "runltp" command. I now below
> command but do not know the argument to pass.
> ./runltp -p -l <log file name> -f <testcase name>
> 
> Is there any way to run ?
> 
> 
> netns_breakns_ns_exec_ipv4_
> netns_breakns_ns_exec_ipv6_
> netns_breakns_ns_exec_ipv4_
> netns_breakns_ns_exec_ipv6_
> netns_breakns_ip_ipv4_netli
> netns_breakns_ip_ipv6_netli
> netns_breakns_ip_ipv4_ioctl
> netns_breakns_ip_ipv6_ioctl
> netns_comm_ns_exec_ipv4_net
> netns_comm_ns_exec_ipv6_net
> netns_comm_ns_exec_ipv4_ioc
> netns_comm_ns_exec_ipv6_ioc
> netns_comm_ip_ipv4_netlink
> netns_comm_ip_ipv6_netlink
> netns_comm_ip_ipv4_ioctl
> netns_comm_ip_ipv6_ioctl

The easiest way is to create custom runtest file, i.e. copy
runtest/containers to new file and delete what you do not want to run.
Then you can pass the newly created file name via the -f argument.

-- 
Cyril Hrubis
chrubis@suse.cz

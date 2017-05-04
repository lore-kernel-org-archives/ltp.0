From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 May 2017 21:51:52 +0200
Subject: [LTP] [RFC PATCH v5 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <20170504164136.46444e27@linux-v3j5>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <20170503160751.1634-3-pvorel@suse.cz>
 <20170504164136.46444e27@linux-v3j5>
Message-ID: <20170504195152.fuflgxom4vqjlbwg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> > +	struct in_addr mask;
> > +
> > +	memset(&mask, 0, sizeof(mask));

> FYI for these memsets you could use 'struct foo bar = { 0 }' instead. Although
> it generates warnings on older compilers if the struct starts with another
> composite data type.

Right, I used it for struct in_addr and in6_addr. Not used it for struct msg as it
contains another struct (even it does not produce a warning when compiled with
--std=gnu89).

> > +	struct {
> > +		struct nlmsghdr nlhdr;
> > +		struct ifaddrmsg addrmsg;
> > +	} msg;



> > +	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
> > +	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
> > +	msg.nlhdr.nlmsg_type = RTM_GETADDR;
> > +	msg.addrmsg.ifa_family = family;
> > +
> > +	send(sock, &msg, msg.nlhdr.nlmsg_len, 0);
> > +	len = recv(sock, buf, sizeof(buf), 0);
> > +	retmsg = (struct nlmsghdr *)buf;

> No error checking? I suppose it is unlikely to fail, but it can't hurt.
IMHO NLMSG_OK RTA_NEXT macros do some sort of checks [1], [2]. Sample code [3] checks for
more, but that's IMHO irrelevant.

> > +
> > +	while NLMSG_OK(retmsg, len) {
> > +		struct ifaddrmsg *retaddr;
> > +		struct rtattr *retrta;
> > +		char pradd[128];
> > +		int attlen;
> > +
> > +		retaddr = (struct ifaddrmsg *)NLMSG_DATA(retmsg);
> > +		retrta = (struct rtattr *)IFA_RTA(retaddr);
> > +		attlen = IFA_PAYLOAD(retmsg);
> > +
> > +		while RTA_OK(retrta, attlen) {
> > +			if (retrta->rta_type == IFA_ADDRESS) {
> > +				inet_ntop(family, RTA_DATA(retrta), pradd, sizeof(pradd));
> > +				if (!strcmp(pradd, ip_str))
> > +					return retaddr->ifa_prefixlen;
> > +			}
> > +			retrta = RTA_NEXT(retrta, attlen);
> > +
> > +		}
> > +		retmsg = NLMSG_NEXT(retmsg, len);
> > +	}
> > +
> > +	return -1;
> > +}
> > +

> Thank you,
> Richard.
Thanks for your comments and time!
Petr


[1] http://man7.org/linux/man-pages/man3/netlink.3.html
[2] http://man7.org/linux/man-pages/man3/rtnetlink.3.html
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/bpf/bpf_load.c?id=refs/tags/v4.11#n535

From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Nov 2015 11:50:13 -0500 (EST)
Subject: [LTP] [PATCH 2/2] Optimise grep action in cpuset_syscall_test
In-Reply-To: <20151116163744.GH17888@rei.suse.cz>
References: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
 <1444872089-30094-2-git-send-email-sunyuan3@huawei.com>
 <73184761.4412729.1446800511159.JavaMail.zimbra@redhat.com>
 <20151116163744.GH17888@rei.suse.cz>
Message-ID: <896303530.9826898.1447692613760.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Yuan Sun" <sunyuan3@huawei.com>, ltp@lists.linux.it
> Sent: Monday, 16 November, 2015 5:37:44 PM
> Subject: Re: [LTP] [PATCH 2/2] Optimise grep action in cpuset_syscall_test
> 
> Hi!
> > > +	task_policy=$(grep -e "  *stack  *anon" | \
> > > +			awk '{print $2}' $TEST_PROCNUMA)
> > 
> > Shouldn't this last one be:
> > +	task_policy=$(grep -e "  *stack  *anon" $TEST_PROCNUMA | \
> > +			awk '{print $2}')
> > 
> 
> Looks like an obvious typo to me. Can you please push fix?

This should be fixed already. Yuan sent v2, where he fixed this:

commit ca77742387f0bd4e42c39b1c70e5995be3433687
Author: Yuan Sun <sunyuan3@huawei.com>
Date:   Mon Nov 9 16:05:34 2015 +0800
    cpuset_syscall_test: simplify grep actions

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

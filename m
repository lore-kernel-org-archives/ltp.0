From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Nov 2015 17:37:44 +0100
Subject: [LTP] [PATCH 2/2] Optimise grep action in cpuset_syscall_test
In-Reply-To: <73184761.4412729.1446800511159.JavaMail.zimbra@redhat.com>
References: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
 <1444872089-30094-2-git-send-email-sunyuan3@huawei.com>
 <73184761.4412729.1446800511159.JavaMail.zimbra@redhat.com>
Message-ID: <20151116163744.GH17888@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	task_policy=$(grep -e "  *stack  *anon" | \
> > +			awk '{print $2}' $TEST_PROCNUMA)
> 
> Shouldn't this last one be:
> +	task_policy=$(grep -e "  *stack  *anon" $TEST_PROCNUMA | \
> +			awk '{print $2}')
> 

Looks like an obvious typo to me. Can you please push fix?

-- 
Cyril Hrubis
chrubis@suse.cz

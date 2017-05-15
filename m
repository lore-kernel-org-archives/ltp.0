From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 May 2017 15:23:04 +0200
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <623640767.11529328.1494854136525.JavaMail.zimbra@redhat.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <59198103.4070308@cn.fujitsu.com>
 <623640767.11529328.1494854136525.JavaMail.zimbra@redhat.com>
Message-ID: <20170515132304.GB12586@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It seems that pselect woke up early on RHEL5.11GA.
> 
> Yes, I see that too. It fails pretty often, even on KVM guest.
> 
> pselect6(0, [], NULL, NULL, {0, 2000000}, {NULL, 8}) = 0 (Timeout) <0.001822>
> pselect6(0, [], NULL, NULL, {0, 10000000}, {NULL, 8}) = 0 (Timeout) <0.009775>
> pselect6(0, [], NULL, NULL, {0, 100000000}, {NULL, 8}) = 0 (Timeout) <0.099808>

Looks like a bug to me, the timers are not allowed to wake up sooner.

-- 
Cyril Hrubis
chrubis@suse.cz

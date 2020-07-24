From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 24 Jul 2020 12:06:54 -0400
Subject: [LTP] [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200724131845.GB24626@dell5510>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com> <20200724131845.GB24626@dell5510>
Message-ID: <1595606814.5211.251.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-07-24 at 15:18 +0200, Petr Vorel wrote:

> 
> > Other than the policy "action" - measure/dont_measure,
> > audit/dont_audit, appraise/dont_appraise - being the first keyword,
> > the ordering of the policy options and flags is flexible. ?Most
> > policies do provide the "func" option immediately following the
> > "action". ?This would normally work.
> OK, is this correct?
> if ! grep '^measure.*func=KEXEC_CMDLINE' $IMA_POLICY >/dev/null; then

Yes, that works.

> 
> @Mimi, @Lachlan: if you both ack my changes, I can fix the code before merging.

That's fine. Feel free to add my Reviewed-by.

Mimi

> If there are more changes needed and thus Lachlan plan new version, please use
> my patches from https://patchwork.ozlabs.org/project/ltp/list/?series=191990&state=*
> (download https://patchwork.ozlabs.org/series/191990/mbox/ and import it with "git am")
> or clone my github fork and use kexec.v3.fixes branch:
> https://github.com/pevik/ltp/tree/ima/kexec.v3.fixes).


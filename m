From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Mar 2018 14:30:49 +0100
Subject: [LTP] [RFC] [PATCH] shell: ROD_SILENT: Print std{out,
 err} on failure
In-Reply-To: <876060w2m5.fsf@rpws.prws.suse.cz>
References: <20180212150302.23347-1-chrubis@suse.cz>
 <87efle670i.fsf@rpws.prws.suse.cz> <20180313124647.GA28772@rei>
 <876060w2m5.fsf@rpws.prws.suse.cz>
Message-ID: <20180313133049.GA21673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> LGTM except that you could maybe use ${ } instead of $( ) as a small
> >> optimisation.
> >
> > I do not get it either. Where should I put the ${} insetad of $()?
> 
> Sorry I was probably wrong, unless you can somehow change from variable
> substitution to redirecting from a group (that is {} > $var not
> var=${}).

So can I consider the original patch acked?

-- 
Cyril Hrubis
chrubis@suse.cz

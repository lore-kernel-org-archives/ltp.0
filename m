From: Leo Liang <ycliang@andestech.com>
Date: Thu, 22 Jul 2021 14:32:32 +0800
Subject: [LTP] [PATCH v4,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <62262681-222f-8d09-a100-0d7be0c7526f@jv-coder.de>
References: <20210719092239.GA1475@atcfdc88> <YPgxJwx795fhXgLa@pevik>
 <62262681-222f-8d09-a100-0d7be0c7526f@jv-coder.de>
Message-ID: <20210722063232.GA28553@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,
On Thu, Jul 22, 2021 at 12:35:59PM +0800, Joerg Vehlow wrote:
> Hi,
> 
> On 7/21/2021 4:37 PM, Petr Vorel wrote:
> > Hi Leo,
> >
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >
> >>   	rmdir cgroup/0 cgroup/1
> >> -	umount cgroup/
> >> +	tst_umount cgroup/	# Avoid possible EBUSY error
> >>   }
> >>   #---------------------------------------------------------------------------
> >> @@ -193,7 +193,7 @@ test3()
> >>   	wait $pid2 2>/dev/null
> >>   	rmdir $cpu_subsys_path/0 2> /dev/null
> >> -	umount cgroup/ 2> /dev/null
> >> +	tst_umount cgroup/ 2> /dev/null		# Avoid possible EBUSY error
> > I'd prefer: # keep "/" to avoid possible EBUSY error
> > But that can be changed before merge.
> >
> > More I'm interested if other maintainers agree with me about this approach.
> > (keep / here instead of in tst_umount())
> I had a first look at this patches and was curious, what the reasoning 
> behind the "/" is.
> The comment you suggest is wrong. The / was introduced to prevent 
> unmounting some other mountpoint,
> where the device was cgroup.
> Imho the approach of adding a / to the end was wrong and intransparent. 
> I would rather use "./cgroup" or "$PWD/cgroup".
> If possible, I'd actually change tst_umount, to always unmount the 
> mountpoint and not the device, i.e. if the given path is not an absolute 
> path, make it absolute (e.g. by prepending $PWD").
> This way the check if the mountpoint exist wouldn't be the fuzzy thing 
> it is right now.
> 
> As for the comment ("# Avoid possible EBUSY error"): Honestly I'd drop 
> it and like in the c-api make using tst_umount instead of plain umount 
> the default, for the same reasons.

Got it!
Thanks for the detailed explanation!
I will send a v5 patch for this modification.
(making the path absolute inside tst_umount)

> 
> >>   	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
> >>   		tst_res TFAIL "lockdep BUG was found"
> >> @@ -254,7 +254,7 @@ test5()
> >>   	mount -t cgroup none cgroup 2> /dev/null
> >>   	mkdir cgroup/0
> >>   	rmdir cgroup/0
> >> -	umount cgroup/ 2> /dev/null
> >> +	tst_umount cgroup/ 2> /dev/null		# Avoid possible EBUSY error
> > I'd drop stderr redirection here. It was here originally, but I suppose it's not
> > needed when using tst_umount. But that can be done during merge.
> +1

This change will be included in the next patch as well.
Thanks again!

Best regards,
Leo

> Joerg

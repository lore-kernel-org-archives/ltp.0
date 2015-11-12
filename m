From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Nov 2015 08:41:15 -0500 (EST)
Subject: [LTP] [PATCH] open_posix_testsuite: add set_affinity_single()
In-Reply-To: <20151112130952.GB19653@rei.lan>
References: <46ff3d4f262abe122b1579681c0e568857c3f9dc.1447332053.git.jstancek@redhat.com>
 <20151112130952.GB19653@rei.lan>
Message-ID: <1524656392.7427722.1447335675915.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 12 November, 2015 2:09:52 PM
> Subject: Re: [LTP] [PATCH] open_posix_testsuite: add set_affinity_single()
> 
> Hi!
> > +static int get_present_cpu_from_sysfs(void)
> > +{
> > +	FILE *f;
> > +	int cpu = -1;
> > +
> > +	f = fopen("/sys/devices/system/cpu/present", "r");
> > +	if (!f)
> > +		return -1;
> > +	fscanf(f, "%d", &cpu);
> > +	fclose(f);
> > +
> > +	return cpu;
> > +}
> > +
> > +static int get_present_cpu_from_cpuinfo(void)
> > +{
> > +	FILE *f;
> > +	int cpu = -1;
> > +	char line[4096];
> > +
> > +	f = fopen("/proc/cpuinfo", "r");
> > +	if (!f)
> > +		return -1;
> > +
> > +	while (!feof(f)) {
> > +		if (!fgets(line, sizeof(line), f))
> > +			return -1;
> > +		/*
> > +		 * cpuinfo output is not consistent across all archictures,
> > +		 * it can be "processor        : N", but for example on s390
> > +		 * it's: "processor N: ...", so ignore any non-number
> > +		 * after "processor"
> > +		 */
> > +		if (sscanf(line, "processor%*[^0123456789]%d", &cpu) == 1)
> > +			break;
> > +	}
> > +	fclose(f);
> > +
> > +	return cpu;
> > +}
> > +
> > +static int set_affinity_single(void)
> > +{
> > +	int cpu;
> > +
> > +	cpu = get_present_cpu_from_sysfs();
> > +	if (cpu < 0)
> > +		cpu = get_present_cpu_from_cpuinfo();
> 
> We should probably fallback here to cpu = 0 in case that we have failed
> to parse the cpuinfo. Not that it's likely to happen.
> 
> So I would do here:
> 
> 	cpu = get_present_cpu_from_sysfs();
> 
> 	if (cpu >= 0)
> 		goto set_affinity;
> 
> 	cpu = get_present_cpu_from_cpuinfo();
> 
> 	if (cpu >= 0)
> 		goto set_affinity;
> 
> 	fprintf(stderr, "WARNING: Failed to detect present cpu using cpu=0\n");
> 
> 	cpu = 0;
> 
> set_affinity:
> 	return set_affinity(cpu);
> 
> > +	return set_affinity(cpu);
> > +}
> > +
> >  #else
> >  static int set_affinity(int cpu)
>                             ^
> 			    You should also rename this stub for
> 			    non-linux OSes.
> 
> Otherwise it looks good, acked.

Pushed with changes you suggested.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

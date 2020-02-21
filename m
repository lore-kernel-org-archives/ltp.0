From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Feb 2020 13:16:18 +0100
Subject: [LTP] [PATCH v4 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200218162739.GA9985@rei.lan>
References: <20200208092014.24824-1-liwang@redhat.com>
 <20200218162739.GA9985@rei.lan>
Message-ID: <20200221121618.GA16421@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Cyril,

> > +	if (FILE_LINES_SCANF("/proc/meminfo",
> > +				"MemAvailable: %ld", &mem_avail)) {
> > +		/*
> > +		 * Using "MemFree:" on kernel that doesn't have
> > +		 * "MemAvailable:" in Meminfo
> > +		 */
> > +		tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
> > +
> > +		mem_avail = SAFE_READ_MEMINFO("MemFree:");
> > +	}

> I guess that we don't have to bother with MemAvailable here, since we do
> drop the system caches the MemFree should be equal to MemAvailable. So I
> would be for reading just MemFree unconditionally here.

> If you agree with this change I can change it before applying.

Merged both patches with this change and my docs change.

Kind regards,
Petr

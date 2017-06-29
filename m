From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Jun 2017 10:45:57 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print sysctl settings
In-Reply-To: <20170628140406.GA27262@rei.lan>
References: <20170425100335.20017-1-pvorel@suse.cz>
 <20170626100447.f3kviwhmtjy2qbdu@dell5510>
 <20170627122049.GA12689@rei.lan>
 <20170627160623.dc5ok6ckuxahxnvl@dell5510>
 <20170628140406.GA27262@rei.lan>
Message-ID: <20170629084557.2wldyj2j6jj4jjey@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> I would do that as well, I doubt that values such as cdrom speed are of
> any value for us. Maybe we should just create a whitelist and print only
> these variables that we find interesting.

> For sysctl that would be as easy as:

> for knob in foo.bar1 foo.bar2 ...; do
> 	sysclt $knob
> done

> The question is of course which ones. Looking at the sysctl output
> settings related to vm overcommit and few from kernel.* namespace looks
> most relevant to me. I suppose you want to add some network knobs as
> well.
Cyril, to be honest I don't know which ones are the most relevant for networking :(.
Alexey, which are interesting for you?


Kind regards,
Petr

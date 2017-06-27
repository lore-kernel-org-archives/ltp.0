From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jun 2017 14:20:49 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print sysctl settings
In-Reply-To: <20170626100447.f3kviwhmtjy2qbdu@dell5510>
References: <20170425100335.20017-1-pvorel@suse.cz>
 <20170626100447.f3kviwhmtjy2qbdu@dell5510>
Message-ID: <20170627122049.GA12689@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +echo
> > +echo 'sysctl settings:'
> > +sysctl -a
> 
> Ping.
> It might be useful to get output of env to see environment variables.

Hmm, I find this to be a bit too verbose, do we really have to print all
the variables?

Can't we grep a few interesting ones and limit the output to something
as 20 lines?

-- 
Cyril Hrubis
chrubis@suse.cz

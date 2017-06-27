From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Jun 2017 18:06:23 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print sysctl settings
In-Reply-To: <20170627122049.GA12689@rei.lan>
References: <20170425100335.20017-1-pvorel@suse.cz>
 <20170626100447.f3kviwhmtjy2qbdu@dell5510>
 <20170627122049.GA12689@rei.lan>
Message-ID: <20170627160623.dc5ok6ckuxahxnvl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +echo
> > > +echo 'sysctl settings:'
> > > +sysctl -a

> > Ping.
> > It might be useful to get output of env to see environment variables.

> Hmm, I find this to be a bit too verbose, do we really have to print all
> the variables?

> Can't we grep a few interesting ones and limit the output to something
> as 20 lines?
You're right. I'd grep something like:
env |grep -m 20 -e PATH -e LTP -e RHOST -e IPV4 -e IPV6
These are just for network related tests, would you propose some more?
The problem with environment variables (at least for network.sh) is that they are set for
subshell (child process), so they are not visible when env is running in ver_linux. We
need to put it into scripts which set them. Either simple echo, or use 'set -x' before
exporting variables and 'set +x' after.

Do you want to limit sysctl output somehow as well?


Kind regards,
Petr

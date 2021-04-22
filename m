From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Apr 2021 10:30:24 +0200
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <YH7Z8nOX90qjsMpa@yuki>
References: <YH7Z8nOX90qjsMpa@yuki>
Message-ID: <YIE0INnCJOMGYQQR@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thank you for bringing the discussion to upstream runltp-ng.

I'd prefer to add the project to ltp git, in runltp-ng/ in root directory.
And add either a symlink runltp-ng/runltp-ng to the root directory or have a
shell script which runs it:
perl -I$(readlink -f $0)/runltp-ng $(readlink -f $0)/runltp-ng/runltp-ng $@

Kind regards,
Petr


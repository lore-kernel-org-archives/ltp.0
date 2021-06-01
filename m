From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jun 2021 11:51:29 +0200
Subject: [LTP] [PATCH 2/3] CI: Rename travis script directory
In-Reply-To: <YLX7K7oPmSSqXfxO@yuki>
References: <20210531165052.8731-1-pvorel@suse.cz>
 <20210531165052.8731-3-pvorel@suse.cz> <YLX5vtHAFVWUmjmU@yuki>
 <YLYAg9oM0XL4Q0/I@pevik> <YLX7K7oPmSSqXfxO@yuki>
Message-ID: <YLYDITE2xCkzfAOX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > I'm sorry, didn't read carefully that the first ack isn't for whole patchset,
> > thus merged whole patchset with your ack.

> The rest looks good as well and we really need working CI so no
> problem...
FYI: there are temporary repository sync problem on Tumbleweed
(problematic obviously both last Travis CI build and new GitHub
Actions builds):

No provider of 'ruby2.5-rubygem-asciidoctor' found.
https://travis-ci.org/github/linux-test-project/ltp/jobs/773129654
https://github.com/linux-test-project/ltp/runs/2717311009

It should be fixed soon.

Kind regards,
Petr

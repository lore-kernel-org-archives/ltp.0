From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Jun 2021 10:44:39 +0200
Subject: [LTP] LTP environment setup
In-Reply-To: <BY5PR22MB1826245B4D2C69C3553F0DDAF30E9@BY5PR22MB1826.namprd22.prod.outlook.com>
References: <BY5PR22MB1826245B4D2C69C3553F0DDAF30E9@BY5PR22MB1826.namprd22.prod.outlook.com>
Message-ID: <YNL0d39i3OOOIft/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Can you provide any links or documents on how to set up LTP environment from scratch?

What exactly are you looking for?

Compiling and installing LTP can be quite easy, that's just usuall ./configure && make && make install.

If you are looking for build/run dependencies we recently started to
work on a script that prints list of packages when given a distribution
name, see https://github.com/metan-ucw/runltp-ng/blob/master/install_pkg.pm

-- 
Cyril Hrubis
chrubis@suse.cz

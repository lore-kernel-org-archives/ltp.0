From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jul 2018 16:45:55 +0200
Subject: [LTP] [RFC] new LTP testrunner
In-Reply-To: <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
References: <20180717114328.GB27873@rei>
 <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
Message-ID: <20180717144555.GA22013@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - replacing runltp + ltp-pan
> What I'm missing is the local use-case we have now. Something
> like backend:local, that will run the test on local system
> and produce same format of results. ssh into localhost
> adds complexity - some test wrapper might not know the
> password for system it has been spawned on.

It's there but not in the README, there is a sh backend that just runs
the tests in a localy executed shell see --help.

But I would like to discourage running the testcases locally for any
test automation/CI.

> The way we coped with (fatal) issues is pre-processing
> runtest files based on kernel version, package versions,
> architecture, etc.

This is something I wanted to avoid if possible because it requires to
maintain a database which time consuming and prone to errors.

> IMO backend:local (and ssh) might be closest to what people do now.
>
> - RFE: filter tests
> have ability to run only some tests based on some filter
> which is very common question I get about runltp

Yes, this is missing, but easy to add.

> - RFE: skip build/installation
> for some cross-compiling users
>   
> - "All backends needs to be able to reach internet"
> Why is this needed?

Just because the tool is expected to install LTP from GitHub.

But in the latest version if there is /opt/ltp/ already present on the
target machine it's not reinstalled unless you request it.

As I said it's still in a proof-of-concept state...

-- 
Cyril Hrubis
chrubis@suse.cz

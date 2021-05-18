From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 May 2021 11:59:01 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <235d2495-92af-7638-c468-9456dd202296@bell-sw.com>
References: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
 <YKLKn3o7A38/nyjt@pevik>
 <235d2495-92af-7638-c468-9456dd202296@bell-sw.com>
Message-ID: <YKOP5cWttVUANr0i@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> The test is now independent of various machine settings
> >> regarding the test host name as it adds predefined names
> >> and aliases to /etc/hosts file and restores it to its
> >> original state after completing the test.
> > 
> >> This should fix the following failures:
> >> * when gethostname() returns an alias name that doesn't
> >>   match canonical name;
> >> * No AAAA record for the returned name from gethostname().
> > 
> >> Addresses and names added to /etc/hosts are more or less
> >> unique, so that there are no conflicts with the existing
> >> configuration.
> > 
> >> Also most of the duplicate code is now gone.
> > 
> > Thanks a lot. On a first look looks very nice, I'll try to review tomorrow.
> > I'd be for merging this before release as the old code is broken.
> 
> Yeah, I'm for it too.

I would be a bit more cautious now as it's fairly late in the release
process. We already started pre-release testing and got some reports in.
Merging this would invalidate results for this test and would require
re-testing.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 2 Aug 2017 16:41:27 +0300
Subject: [LTP] LTP build issues
In-Reply-To: <87bmnygz31.fsf@our.domain.is.not.set>
References: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
 <120904092.64905035.1501656185854.JavaMail.zimbra@redhat.com>
 <87bmnygz31.fsf@our.domain.is.not.set>
Message-ID: <20170802134127.v3ojkmmuomv4bb72@yury-thinkpad>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Did you re-run "make autotools" and "./configure"?
> > ./include/lapi/syscalls.h should be generated during configure.
> 
> Maybe also try 'make distclean' first, then 'make autotools' etc. I
> should have put that in the commit message as it is a change to the
> build system itself.

'git clean -f', 'make autotools' and './configure' did help. And all
other failures did also disappear. Thank you, and sorry for the noise.

Yury

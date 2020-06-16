From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 16 Jun 2020 18:40:11 -0400
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200615200121.GG129694@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch> <20200615200121.GG129694@glitch>
Message-ID: <1592347211.11061.250.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2020-06-15 at 17:01 -0300, Bruno Meneguele wrote:
> On Mon, Jun 15, 2020 at 04:41:34PM -0300, Bruno Meneguele wrote:
> > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:

> > > > The boot_aggregate.trs and boot_aggregate.log files are being created
> > > > in the tests/ directory. ?Is that directory read-only?
> > > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> > > 
> > 
> > Yes, same thing here.. but didn't really check the reason for that. Will
> > take a time later to see what's happening.

Cloning as root will cause that to happen.

$ sudo git clone git://git.code.sf.net/p/linux-ima/ima-evm-utils --branch next-testing
Cloning into 'ima-evm-utils'...
remote: Enumerating objects: 1154, done.
remote: Counting objects: 100% (1154/1154), done.
remote: Compressing objects: 100% (1052/1052), done.
remote: Total 1154 (delta 736), reused 182 (delta 96)
Receiving objects: 100% (1154/1154), 335.12 KiB | 0 bytes/s, done.
Resolving deltas: 100% (736/736), done.
Checking connectivity... done.

$ ls -lat ima-evm-utils/ | grep tests
drwxr-xr-x.  2 root root   220 Jun 16 18:28 tests

Mimi

From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 06 Feb 2018 08:19:19 -0500
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180126131650.GC12731@rei>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510> <20180126131650.GC12731@rei>
Message-ID: <1517923159.13312.14.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2018-01-26 at 14:16 +0100, Cyril Hrubis wrote:
> Hi!
> > > For the new template format measurement lists, walking the measurement
> > > list, re-calculating the PCRs and comparing them with the HW or vTPM
> > > PCRs fail. ??The ima-evm-utils package has a working version. ??Invoke
> > > "evmctl" with the "ima_measurement" option.
> > So you mean that src/ima_measure.c is broken and should be replaced by evmctl from your
> > repository on sf.net [4]? Fortunately this package is on all major distros [5] (except
> > Debian, but Ubuntu package is installable on Debian), so we don't need to include your
> > repository as submodule.
> 
> Well if the package is included in major distributions we may as just
> state the dependency in the README and TCONF the test if it's not
> installed.

I've cleaned up "evmctl ima_measurement" a bit, so that there are
different levels of output.  The default is to just return errors. 
Verbose (-v) returns the keys used in the verification, the calculated
PCR and the HW PCR. Verbose+ (-v -v) includes the measurement list as
well.

example:
$ sudo src/evmctl ima_measurement -k "/etc/keys/ima/distro-cert-6e6c1046.der,
/etc/keys/ima/app-cert-c4e2426e.der, /etc/keys/ima/local-cert-14c2d147.der"
-v /sys/kernel/security/ima/binary_runtime_measurements

key 1: 6e6c1046 /etc/keys/ima/distro-cert-6e6c1046.der
key 2: c4e2426e /etc/keys/ima/app-cert-c4e2426e.der
key 3: 14c2d147 /etc/keys/ima/local-cert-14c2d147.der
PCRAgg 10: a19dfba0ac6eef26cb342470374b0808aea80a12
HW PCR-10: a19dfba0ac6eef26cb342470374b0808aea80a12

The patches for this version are in the next branch.

Mimi


From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jan 2018 14:16:50 +0100
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180125203057.mzzpilp6i43xftka@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
Message-ID: <20180126131650.GC12731@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > For the new template format measurement lists, walking the measurement
> > list, re-calculating the PCRs and comparing them with the HW or vTPM
> > PCRs fail. ??The ima-evm-utils package has a working version. ??Invoke
> > "evmctl" with the "ima_measurement" option.
> So you mean that src/ima_measure.c is broken and should be replaced by evmctl from your
> repository on sf.net [4]? Fortunately this package is on all major distros [5] (except
> Debian, but Ubuntu package is installable on Debian), so we don't need to include your
> repository as submodule.

Well if the package is included in major distributions we may as just
state the dependency in the README and TCONF the test if it's not
installed.

-- 
Cyril Hrubis
chrubis@suse.cz

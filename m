From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2020 10:02:21 +0200
Subject: [LTP] [PATCH] IMA: Add a test to verify importing a certificate
 into custom keyring
In-Reply-To: <20200717205721.18173-1-t-josne@linux.microsoft.com>
References: <20200717205721.18173-1-t-josne@linux.microsoft.com>
Message-ID: <20200731080221.GA14041@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lachlan,

> A test for verifying importing an x509 certificate into a keyring and
> validating the key measurement performed by IMA is needed.

I suppose you're going to send new version of this patch (rebased + fix
according to Mimi's comments).

IMHO that should be your last not yet merged patch.

FYI: I'm planning to fix ima_tpm.sh and then implement autoloading IMA policy
(when possible).

Kind regards,
Petr

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 31 Jul 2020 14:31:23 -0700
Subject: [LTP] [PATCH] IMA: Add a test to verify importing a certificate
 into custom keyring
In-Reply-To: <20200731080221.GA14041@dell5510>
References: <20200717205721.18173-1-t-josne@linux.microsoft.com>
 <20200731080221.GA14041@dell5510>
Message-ID: <edf26ac1-6378-c632-9e91-5c09141639af@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/31/20 1:02 AM, Petr Vorel wrote:

Hi Petr,

>> A test for verifying importing an x509 certificate into a keyring and
>> validating the key measurement performed by IMA is needed.
> 
> I suppose you're going to send new version of this patch (rebased + fix
> according to Mimi's comments).
> 
> IMHO that should be your last not yet merged patch.
> 
> FYI: I'm planning to fix ima_tpm.sh and then implement autoloading IMA policy
> (when possible).
> 

Yes - Lachlan will send the new version of the patch set (rebased to 
your latest changes and also addressing Mimi's comments).

thanks,
  -lakshmi


From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 17 Aug 2020 15:18:01 -0400
Subject: [LTP] [PATCH v3 0/4] IMA: verify measurement of certificate
 imported into a keyring
In-Reply-To: <20200817130916.27634-1-pvorel@suse.cz>
References: <20200817130916.27634-1-pvorel@suse.cz>
Message-ID: <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2020-08-17 at 15:09 +0200, Petr Vorel wrote:
> Hi Mimi, Lakshmi,
> 
> changes v2->v3:
> fixed regression in my third commit.
> (please verify it on installed LTP, or at least run make install in
> testcases/kernel/security/integrity/ima/datafiles/ima_keys/)

I did, but nothing changed.  I probably need to set an environment
variable.

After building and installing LTP, it's finding the file, but some of
the issues still exist:

ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_keys 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
grep: Unmatched ( or \(
ima_keys 1 TPASS: specified keyrings were measured correctly
ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
keyctl_session_to_parent: Operation not permitted
ima_keys 2 TPASS: logged certificate matches the original

IMA policy:
measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf 
measure func=KEY_CHECK keyrings=key_import_test template=ima-buf 

Mimi


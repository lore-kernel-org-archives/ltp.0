From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 28 Aug 2020 06:59:45 -0400
Subject: [LTP] [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <20200820090824.3033-5-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
Message-ID: <59586987f6050a0cb5b744284895373b7c8232dd.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-08-20 at 11:08 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> The IMA subsystem supports measuring certificates that have been
> imported into either system built-in or user-defined keyrings.
> A test to verify measurement of a certificate imported
> into a keyring is required.
> 
> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into a newly-created, user-defined keyring and measured
> correctly by the IMA subsystem.
> 
> A certificate used by the test is included in the `datafiles/keys`
> directory.
> 
> There can be restrictions on importing a certificate into a builtin
> trusted keyring. For example, the `.ima` keyring requires that
> imported certs be signed by a kernel private key in certain
> kernel configurations. For this reason, this test defines
> a user-defined keyring and imports a certificate into that.

FYI, similar restrictions could be defined for userspace keyrings. 
Refer to Mat Martineau's LSS 2019 talk titled "Using and Implementing
Keyring Restrictions for Userspace" and the keyctl's "restrict_keyring"
option.

Mimi


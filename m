From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 2 Jun 2017 07:45:48 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] do not test undefined behavior
In-Reply-To: <59302FE8.5020502@oracle.com>
References: <59302FE8.5020502@oracle.com>
Message-ID: <2137559651.27716748.1496403948863.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The test_flags() function's first test for each file is an attempt
> to write a space character into that file (NULL translates to " ").
> The test expects that this attempt will be successful and that the flag
> will get set to 0.
> 
> This behavior was changed in Linux kernel between versions 3.13.74 and
> 3.14. with the commit a742c59de66ea080afa3edaf3428b3cdd5aa87cd
> "cgroup: unify cgroup_write_X64() and cgroup_write_string()".
> With the new behavior, attempting to write a space character into
> a flag file returns EINVAL; I find this behavior more consistent.
> 
> Flag files are an interface which is known to expect numeric values.
> We already have a test in test_flags() which covers invalid input.
> We should not attempt to write a space into a flag file because
> the resulting behavior is not strictly defined anywhere.
> Therefore, it would be best to drop the first test.

Hi,

no objections to change you are proposing, just comments on format:

You're missing Signed-off-by line. 
Patch appears to be mangled, all tabs were replaced by spaces.

Did you send the patch with git send-email? Would you care to
try resend? 

Regards,
Jan

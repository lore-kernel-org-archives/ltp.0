From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2020 09:55:34 -0500 (EST)
Subject: [LTP] [PATCH] Fix prctl02
In-Reply-To: <20200123143137.23214-1-mdoucha@suse.cz>
References: <20200123143137.23214-1-mdoucha@suse.cz>
Message-ID: <239304412.3515101.1579791334045.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The prctl() system call takes 5 integer arguments but only 3 of them were
> passed in the test. This means that the system call read random garbage
> from stack in place of the two missing arguments and failed even on some
> perfectly valid combinations of arguments on some platforms.
> 
> - Fixed arguments in test case 9 (second PR_SET_NO_NEW_PRIVS)
> - Dropped test case 13 (PR_CAP_AMBIENT) because the args are valid
> - Dropped test case 14 (PR_GET_SPECULATION_CTRL) because the args are valid

Can we make them invalid and keep the test cases?
For example:
 PR_CAP_AMBIENT arg2 could be num_invalid
 PR_GET_SPECULATION_CTRL arg3 could be num_1

The rest looks good to me.


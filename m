From: Stephen Kitt <steve@sk2.org>
Date: Tue, 7 Sep 2021 08:14:03 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Use command -v instead of type
In-Reply-To: <20210903110920.28178-1-pvorel@suse.cz>
References: <20210903110920.28178-1-pvorel@suse.cz>
Message-ID: <20210907081403.4f4aa916@heffalump.sk2.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri,  3 Sep 2021 13:09:20 +0200, Petr Vorel <pvorel@suse.cz> wrote:
> to avoid checkbashisms warnings.
> 
> `type' is part of POSIX, but as part of the X/Open Systems Interfaces
> option (XSI) [1]. As Stephen Kitt noted [2] quoting man checkbashisms(1):
> 
>     Note that the definition of a bashism in this context roughly
>     equates to "a shell feature that is not required to be supported
>     by POSIX"; this means that some issues flagged may be permitted
>     under optional sections of POSIX, such as XSI or User Portability.
> 
> => `type' is flagged because it is an optional feature.  
> 
> `command -v' is POSIX (no XSI extension) [3] and we already started to
> using it instead of which (e7302676f, f6cac3660).
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html
> [2] https://unix.stackexchange.com/a/667293
> [3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
> 
> Cc: Stephen Kitt <steve@sk2.org>
> Suggested-by: Adam Katz <khopesh@apache.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Stephen Kitt <steve@sk2.org>

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210907/a12fef28/attachment.sig>

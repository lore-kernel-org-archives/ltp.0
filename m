From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 May 2020 05:04:12 -0400 (EDT)
Subject: [LTP] [PATCH] acct02: fix the ac_version check on big endian
 platforms
In-Reply-To: <20200526113847.6837-1-stanislav.kholmanskikh@oracle.com>
References: <20200526113847.6837-1-stanislav.kholmanskikh@oracle.com>
Message-ID: <1158333456.13771112.1590570252412.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> If we are on a big endian platform where char is signed,
> the following compilation error is emitted:
> 
> acct02.c: In function ?verify_acct?:
> acct02.c:38:37: warning: comparison is always true due to limited range of
> data type [-Wtype-limits]
>  #define ACCT_MEMBER_V3(x) (((struct acct_v3 *)acc)->x)
>                                      ^
> acct02.c:144:6: note: in expansion of macro ?ACCT_MEMBER_V3?
>   if (ACCT_MEMBER_V3(ac_version) != (3 | ACCT_BYTEORDER)) {
> 
> and the test case fails, because it cannot 'decrypt' the ac_version
> from the file:
> 
> acct02.c:238: INFO: Verifying using 'struct acct_v3'
> acct02.c:191: INFO: == entry 1 ==
> acct02.c:146: INFO: ac_version != 3 (-125)
> 
> One way to address that is to explicitly cast the expression
> we compare to (which is int) to the type of ac_version (which is char).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


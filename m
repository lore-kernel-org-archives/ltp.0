Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MwFkj-0005x1-WB
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 13:43:25 +0000
Date: Fri, 9 Oct 2009 15:43:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091009134309.GA8327@schrodinger.suse.cz>
References: <4ABACAA3.2020206@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ABACAA3.2020206@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

Hi!
Here comes just a few comments of some parts of the code (sorry for commenting
old patch, the original mail just got stuck, thus resending).

> b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c

> +char *filename;
> +char *filepath;
> +int fd;
> +
> +int old_inode_version;
> +int new_inode_version;

Global variables should be declared as static, otherwise compiler losts track
of unused global variables and doesn't warn you about them.

> +     if (strcmp(argv[1], "create") == 0) {
> +             printf("%d\n", old_inode_version);
> +             return 0;
> +     } else if (strcmp(argv[1], "chmod") == 0) {
> +             test_chmod();
> +     } else if (strcmp(argv[1], "chown") == 0) {
> +             test_chown();
> +     } else if (strcmp(argv[1], "read") == 0) {
> +             test_read();
> +     } else if (strcmp(argv[1], "write") == 0) {
> +             test_write();
> +     } else if (strcmp(argv[1], "mmap_read") == 0) {
> +             test_mmap_read();
> +     } else if (strcmp(argv[1], "mmap_write") == 0) {
> +             test_mmap_write();
> +     } else {
> +             fprintf(stderr, "wrong file operation: %s\n", argv[1]);
> +             return 1;
> +     }

This is just easier and cleaner with defining field of strings (char *) and
looping trough them. Eg:

#define NPARAMS 4

const char *params[NPARAMS] = {"chmod", "chown", "read", "write"};

for (i = 0; i < NPARAMS; i++)
        if (!strcmp(argv[1], params[i})
                break;

Now you have number of selected param in variable i, so traditionall switch()
could be used. Or if called functions have similar type, array of pointers to
them is even easier.

const void (*(func[NPARAMS])(void) = {test_chmod, test_chown, ...};


> +++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c

Hmm, man 3 free says "if ptr is NULL, no operation is performed"

> +/* Wrap up the free function */
> +#define FREE(tmp)                            \
> +     do {                                    \
> +             if ((tmp) != NULL)              \
> +                     free(tmp);              \
> +     } while (0)                             \

Macro in lowercase is usually considered to be bad practise.

> +/* Insert list2 after list1 */
> +#define insert(list1, list2)                 \
> +     do {                                    \
> +             list2->next = list1->next;      \
> +             list1->next->prev = list2;      \
> +             list2->prev = list1;            \
> +             list1->next = list2;            \
> +     } while (0)
> +


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

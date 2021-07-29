From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Jul 2021 16:12:34 +0800
Subject: [LTP] [PATCH] mbind01: accept MPOL_LOCAL when passing empty set
 for MPOL_PREFERRED
In-Reply-To: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
References: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
Message-ID: <CAEemH2eFpEzzPAW3CLN=68sxzKzjVZrhuExTBUdHUeKFhnfPiA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  static void test_default(unsigned int i, char *p)
>  {
>         struct test_case *tc = &tcase[i];
> @@ -183,7 +196,10 @@ static void do_test(unsigned int i)
>                         tst_res(TFAIL | TTERRNO, "get_mempolicy failed");
>                         return;
>                 }
> -               if (tc->policy != policy) {
> +
> +               if (tc->check_policy)
> +                       tc->check_policy(policy);
> +               else if (tc->policy != policy) {
>                         tst_res(TFAIL, "Wrong policy: %d, expected: %d",
>                                 tc->policy, policy);
>

Seems the error print is reverse, which should be corrected as:

                        tst_res(TFAIL, "Wrong policy: %d, expected: %d",
-                               tc->policy, policy);
+                               policy, tc->policy);



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210729/8ebe60f0/attachment-0001.htm>

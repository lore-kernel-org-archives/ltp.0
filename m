From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Jun 2021 15:40:27 +0200
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <1e7ecce7-2e46-ea46-3c5b-357d53a238c3@suse.cz>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com>
 <YMirQoiYRYsDP7Sb@yuki> <87czsk51fc.fsf@suse.de>
 <1e7ecce7-2e46-ea46-3c5b-357d53a238c3@suse.cz>
Message-ID: <YNHoS1L+0toUtAWT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The test author is guaranteed that the library will not set TST_ERR
> > except via the TEST macro and similar.
> 
> Hi, who decided to guarantee this and where is the guarantee documented?

That is the whole point of the API, keep TST_RET and TST_ERR until
explicitly changed by either chaning them directly or via the TEST()
macro.

> I was planning to document that RTNL_SEND_VALIDATE() and
> RTNL_CHECK_ACKS() will pass error codes found in rtnetlink ACK messages
> through TST_ERR.
> 
> On 17. 06. 21 10:40, Richard Palethorpe wrote:
> > Hello,
> > 
> > Cyril Hrubis <chrubis@suse.cz> writes:
> >> I do not like this fix. If nothing else it's fragile and would make any
> >> patch review for these libraries much harder.
> >>
> >> I would prefer having these functions modified to return the errors
> >> instead even if I have to do the work.
> 
> Changing the return value to always return errno will be a major PITA
> because 95% of error handling happens after some safe_syscall() which
> clobbers errno by calling tst_brk() after failure. And if you only want
> to return error codes from rtnetlink ACK messages, then there's the
> problem what to return when a safe_syscall() fails during cleanup().

For the current code it would be as easy as:

diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index d098173d5..b4b10944d 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -148,10 +148,10 @@ int tst_create_veth_pair(const char *file, const int lineno,
        ret = tst_rtnl_send_validate(file, lineno, ctx);
        tst_rtnl_destroy_context(file, lineno, ctx);

-       if (!ret) {
-               tst_brk_(file, lineno, TBROK | TTERRNO,
-                       "Failed to create veth interfaces %s+%s", ifname1,
-                       ifname2);
+       if (ret) {
+               tst_brk_(file, lineno, TBROK,
+                       "Failed to create veth interfaces %s+%s: %s", ifname1,
+                       ifname2, tst_strerrno(ret));
        }

        return ret;
@@ -182,9 +182,9 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
        ret = tst_rtnl_send_validate(file, lineno, ctx);
        tst_rtnl_destroy_context(file, lineno, ctx);

-       if (!ret) {
+       if (ret) {
                tst_brk_(file, lineno, TBROK | TTERRNO,
-                       "Failed to remove netdevice %s", ifname);
+                       "Failed to remove netdevice %s: %s", ifname, tst_strerrno(ret));
        }

        return ret;
@@ -231,9 +231,9 @@ static int modify_address(const char *file, const int lineno,
        ret = tst_rtnl_send_validate(file, lineno, ctx);
        tst_rtnl_destroy_context(file, lineno, ctx);

-       if (!ret) {
+       if (ret) {
                tst_brk_(file, lineno, TBROK | TTERRNO,
-                       "Failed to modify %s network address", ifname);
+                       "Failed to modify %s network address: %s", ifname, tst_strerrno(ret));
        }

        return ret;
@@ -300,9 +300,9 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
        ret = tst_rtnl_send_validate(file, lineno, ctx);
        tst_rtnl_destroy_context(file, lineno, ctx);

-       if (!ret) {
+       if (ret) {
                tst_brk_(file, lineno, TBROK | TTERRNO,
-                       "Failed to move %s to another namespace", ifname);
+                       "Failed to move %s to another namespace: %s", ifname, tst_strerrno(ret));
        }

        return ret;
@@ -391,9 +391,9 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
        ret = tst_rtnl_send_validate(file, lineno, ctx);
        tst_rtnl_destroy_context(file, lineno, ctx);

-       if (!ret) {
+       if (ret) {
                tst_brk_(file, lineno, TBROK | TTERRNO,
-                       "Failed to modify network route");
+                       "Failed to modify network route", tst_strerrno(ret));
        }

        return ret;
diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
index 1ecda3a9f..c5f1aa0dc 100644
--- a/lib/tst_rtnetlink.c
+++ b/lib/tst_rtnetlink.c
@@ -376,16 +376,14 @@ int tst_rtnl_check_acks(const char *file, const int lineno,
                        tst_brk_(file, lineno, TBROK,
                                "No ACK found for Netlink message %u",
                                msg->nlmsg_seq);
-                       return 0;
+                       return EPROTO;
                }

-               if (res->err->error) {
-                       TST_ERR = -res->err->error;
-                       return 0;
-               }
+               if (res->err->error)
+                       return res->err->error;
        }

-       return 1;
+       return 0;
 }

 int tst_rtnl_send_validate(const char *file, const int lineno,
@@ -394,8 +392,6 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
        struct tst_rtnl_message *response;
        int ret;

-       TST_ERR = 0;
-
        if (tst_rtnl_send(file, lineno, ctx) <= 0)
                return 0;

-- 
Cyril Hrubis
chrubis@suse.cz

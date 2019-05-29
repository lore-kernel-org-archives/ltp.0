From: Christian Amann <camann@suse.com>
Date: Wed, 29 May 2019 11:33:03 +0200
Subject: [LTP] TST_GET_UNUSED_PORT returns ports < 1024
Message-ID: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

when using the TST_GET_UNUSED_PORT macro you sometimes get ports lower
than 1024 which would require a testcase to have the
CAP_NET_BIND_SERVICE capability (or simply run as root).

Of course you could write a wrapper like the following to avoid that
issue, but in my opinion it would be nice to have the option to get
non-root ports directly from the library.

/* Wrapper to to get a non-root port if necessary */
static int get_port(uid_t uid)
{
        static int count = 10;
        int port;

        port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
        if (port < 1000 && uid != 0) {
                if (!count)
                        tst_brk(TBROK, "Could not get fitting port");
                count--;
                return get_port(uid);
        }
        return port;
}

Kind regards,

Christian


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190529/18f11994/attachment.html>

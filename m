From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Dec 2016 14:48:46 +0300
Subject: [LTP] [PATCH 1/1] network/echoes: fix endless loop on error
In-Reply-To: <20161214170604.nycf5yipmdvcyss7@dell5510>
References: <20161129160259.31058-1-pvorel@suse.cz>
 <5846989A.2020104@oracle.com> <20161214170604.nycf5yipmdvcyss7@dell5510>
Message-ID: <5852831E.6070608@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 14.12.2016 20:06, Petr Vorel wrote:
> Hi Alexey,
>
>> Good catch, looks like we could substitute the while loop here with
>> tst_reap_children() library function and remove "echo_struc" as well?
> Could you please push this quick fix? I plan to rewrite test into new API, but probably
> will not manage it until the release.

OK,  but if we want a quick fix here we can just add a single "break" 
after the loop where
it is killing all the left child processes. No need to proceed anyway. 
If you agree I'll push
the patch with the break version:

--- a/testcases/network/tcp_cmds/echo/echoes.c
+++ b/testcases/network/tcp_cmds/echo/echoes.c
@@ -121,7 +121,7 @@ int main(int argc, char *argv[], char *env[])
                                         kill(echo_struc[k].pid, 9);
                                 }
                         }
-
+                       break;
                 }

         }

Thanks,
Alexey

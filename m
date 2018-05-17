From: Li Wang <liwang@redhat.com>
Date: Thu, 17 May 2018 14:21:08 +0800
Subject: [LTP] [PATCH v2] tst_test.sh: achieve TST_RETRY_FUNC function
	in shell
In-Reply-To: <CAEemH2fHfAkjuSgAFcHyrs0Ga5JP91Eg11kbJ6D2jESKTbAOfw@mail.gmail.com>
References: <20180503033414.5601-1-liwang@redhat.com>
 <20180516104437.kgun7upb4sbrwsfj@dell5510>
 <CAEemH2ccJR4aiowoogZ5nmOdQFvcCzUbE0k4A+5h=mW=XVgVnQ@mail.gmail.com>
 <CAEemH2fHfAkjuSgAFcHyrs0Ga5JP91Eg11kbJ6D2jESKTbAOfw@mail.gmail.com>
Message-ID: <CAEemH2faFjQaYqUqaMg+FEeFBPDVoKBkKDc4+0nCbR5UWw469A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

​And also, we'd better skip the TST_ prefix name check in test library,
otherwise we will get LTP warnings like:

<<<test_output>>>
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TWARN: Reserved variable TST_RETRY_FUNC used!
numa01 1 TINFO: The system contains 2 nodes:  0 1
numa01 1 TPASS: NUMA local node and memory affinity
numa01 2 TPASS: NUMA preferred node policy
numa01 3 TPASS: NUMA share memory allocated in preferred node
numa01 4 TPASS: NUMA interleave policy
numa01 5 TPASS: NUMA interleave policy on shared memory
numa01 6 TPASS: NUMA phycpubind policy
numa01 7 TPASS: NUMA local node allocation
numa01 8 TPASS: NUMA MEMHOG policy

----------------
 tst_umount()
 {
        local device="$1"
@@ -255,6 +297,7 @@ tst_run()
                        OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
                        NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
                        NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+                       RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
                        IPV6);;
                        *) tst_res TWARN "Reserved variable TST_$tst_i
used!";;
                        esac
​

​I prefer to merge this change along with your suggestions in PATCH v3 as
well.

Thanks,
Li Wang​
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180517/04f5a587/attachment.html>

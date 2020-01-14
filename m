From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Jan 2020 13:50:43 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E12-rc1-fc79c22=2Ecki_=28stable=29?=
In-Reply-To: <cki.63107281D5.F4HIWEIQDO@redhat.com>
References: <cki.63107281D5.F4HIWEIQDO@redhat.com>
Message-ID: <278993309.1964298.1579027843196.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
>     x86_64:
>      ? LTP

This looks like false positive. Temp path that appears in dmesg
contains "BUG" substring, which is probably what triggered the report.

[ 4199.295202] xfs filesystem being mounted at /mnt/testarea/ltp-qWqNYXdbNM/4T0BUG/mnt_point supports timestamps until 2038 (0x7fffffff)


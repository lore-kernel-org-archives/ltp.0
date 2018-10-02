From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 2 Oct 2018 19:16:51 +0300
Subject: [LTP] [PATCH] device-drivers/acpi: skip certain tests for
 HW-reduced ACPI
In-Reply-To: <20181001124227.GB27555@rei>
References: <1534520593-14253-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <d10e9ad6-0b17-bac4-8f8b-09e8ad5be09a@oracle.com>
 <20181001124227.GB27555@rei>
Message-ID: <d64f1f57-c630-b893-afab-1247917a4fb8@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 10/01/2018 03:42 PM, Cyril Hrubis wrote:
> Hi!
>> Could anybody have a look at this, please?
> 
> Looks OK, I haven't checked the ACPI calls used to get the reduced flag
> are correct though.
> 

Thank you. They work for me.

On an aarch64 box with the ACPI reduced flag set:

[root@bma002-ps ~]# acpixtract -a acpidump.out
<...>
[root@bma002-ps ~]# iasl -d facp.dat
<...>
[root@bma002-ps ~]# less facp.dsl
[root@bma002-ps ~]# grep -i reduced facp.dsl
                       Hardware Reduced (V5) : 1
[root@bma002-ps ~]#

without the patch the test reports:

ltp_acpi    2  TPASS  :  Test-case '1'
ltp_acpi    3  TPASS  :  Test-case '2'
ltp_acpi    4  TFAIL  :  ltp_acpi.c:139: Test-case '3'
ltp_acpi    5  TFAIL  :  ltp_acpi.c:139: Test-case '4'
ltp_acpi    6  TPASS  :  Test-case '5'
ltp_acpi    7  TPASS  :  Test-case '6'
ltp_acpi    8  TPASS  :  Test-case '7'
ltp_acpi    9  TFAIL  :  ltp_acpi.c:139: Test-case '8'
ltp_acpi   10  TPASS  :  Test-case '9'
<<<execution_status>>>

In contrast, here is the output from the same machine with the patch:

ltp_acpi    2  TPASS  :  Test-case '1'
ltp_acpi    3  TPASS  :  Test-case '2'
ltp_acpi    4  TPASS  :  Test-case '3'
ltp_acpi    5  TPASS  :  Test-case '4'
ltp_acpi    6  TPASS  :  Test-case '5'
ltp_acpi    7  TPASS  :  Test-case '6'
ltp_acpi    8  TPASS  :  Test-case '7'
ltp_acpi    9  TPASS  :  Test-case '8'
ltp_acpi   10  TPASS  :  Test-case '9'
<<<execution_status>>>

and the new string in dmesg:

[28580.729499] LTP: starting kernel_misc:ltp_acpi (ltp_acpi)
[28580.738129] ltp_acpi_test: Starting module
[28580.742241] ltp_acpi_test: device registered
[28580.746950] ltp_acpi_test: test-case 0
[28580.750707] ltp_acpi_test: Detected the Hardware-reduced ACPI mode
[28580.756882] ltp_acpi_test: TEST -- acpi_get_handle
[28580.761785] ltp_acpi_test: ACPI object name CP00, type 6


On my x86_64 desktop, where the flag is not set, I see no difference in
test output and dmesg before and after applying the patch.

I.e. everything seems to be working as expected.

Am I applying the patch then?

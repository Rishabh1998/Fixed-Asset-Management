

function filter() {
    var name,description,status, filter, table, tr, td, i, txtValue;
    name = document.getElementById("name");
    description = document.getElementById("description");
    status = document.getElementById("status");
    filter_n = name.value.toUpperCase();
    filter_d = description.value.toUpperCase();
    filter_s = status.value.toUpperCase();
    table = document.getElementById("Table");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
        td_n = tr[i].getElementsByTagName("td")[0];
        td_d = tr[i].getElementsByTagName("td")[1];
        td_s = tr[i].getElementsByTagName("td")[2];
        if (td_n) {
            nameValue = td_n.textContent || td_n.innerText;
            descriptionValue = td_d.textContent || td_d.innerText;
            statusValue = td_s.textContent || td_s.innerText;
            if (nameValue.toUpperCase().indexOf(filter_n) > -1 && descriptionValue.toUpperCase().indexOf(filter_d) > -1 && statusValue.toUpperCase().indexOf(filter_s) > -1) {
                tr[i].style.display = "";

            } else {
                tr[i].style.display = "none";
            }
        }

    }
}


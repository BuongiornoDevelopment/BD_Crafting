let craftingAttuale = null;
let craftingId = null;

window.addEventListener('message', function(event) {
    if (event.data.tipo === 'apriMenu') {
        craftingAttuale = event.data.crafting;
        craftingId = event.data.craftingId;
        document.getElementById('menu-crafting').style.display = 'block';
        mostraRicette();
    } else if (event.data.tipo === 'chiudiMenu') {
        document.getElementById('menu-crafting').style.display = 'none';
    }
});

function mostraRicette() {
    const container = document.getElementById('lista-ricette');
    container.innerHTML = '';
    
    Object.entries(craftingAttuale.ricette).forEach(([ricettaId, ricetta]) => {
        const elemento = document.createElement('div');
        elemento.className = 'ricetta';
        elemento.innerHTML = `
            <img src="nui://ox_inventory/web/images/${ricetta.risultato.item}.png">
            <h3>${ricettaId}</h3>
            <div class="ingredienti">
                ${ricetta.ingredienti.map(ing => 
                    `<div class="ingrediente">
                        ${ing.quantita}x <img src="nui://ox_inventory/web/images/${ing.item}.png"> ${ing.item}
                    </div>`
                ).join('')}
            </div>
            <div class="tempo">⏱️ ${ricetta.tempo / 1000}s</div>
        `;
        
        elemento.onclick = () => iniziaCrafting(ricettaId);
        container.appendChild(elemento);
    });
}

function iniziaCrafting(ricettaId) {
    fetch(`https://${GetParentResourceName()}/iniziaCrafting`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            craftingId: craftingId,
            ricettaId: ricettaId
        })
    });
}

function chiudiMenu() {
    document.getElementById('menu-crafting').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/chiudiMenu`, {
        method: 'POST'
    });
}